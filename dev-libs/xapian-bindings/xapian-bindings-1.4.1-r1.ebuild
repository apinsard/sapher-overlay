# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python2_7 python3_{4..5} )
PYTHON_REQ_USE=threads

USE_PHP="php5-5 php5-6"

PHP_EXT_NAME="xapian"
PHP_EXT_INI="yes"
PHP_EXT_OPTIONAL_USE="php"

#mono violates sandbox, we disable it until we figure this out
#inherit distutils-r1 libtool java-pkg-opt-2 mono-env php-ext-source-r2 toolchain-funcs
inherit libtool java-pkg-opt-2 php-ext-source-r2 toolchain-funcs python-r1

DESCRIPTION="SWIG and JNI bindings for Xapian"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://oligarchy.co.uk/xapian/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
#IUSE="java lua mono perl php python ruby tcl"
IUSE="java lua perl php python ruby tcl"
#REQUIRED_USE="|| ( java lua mono perl php python ruby tcl )"
REQUIRED_USE="|| ( java lua perl php python ruby tcl )"

COMMONDEPEND="dev-libs/xapian:0/30
	lua? ( dev-lang/lua:= )
	perl? ( dev-lang/perl:= )
	python? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		${PYTHON_DEPS}
	)
	ruby? ( dev-lang/ruby:= )
	tcl? ( dev-lang/tcl:= )"
#	mono? ( dev-lang/mono )
DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
	java? ( >=virtual/jdk-1.6 )"
RDEPEND="${COMMONDEPEND}
	java? ( >=virtual/jre-1.6 )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

pkg_setup() {
#	use mono && mono-env_pkg_setup
	use java && java-pkg-opt-2_pkg_setup
}

src_prepare() {
	use java && java-pkg-opt-2_src_prepare

	# http://trac.xapian.org/ticket/702
	export XAPIAN_CONFIG="/usr/bin/xapian-config"

	# Accept ruby 2.0 - patch configure directly to avoid autoreconf
	epatch "${FILESDIR}"/${PN}-1.3.6-allow-ruby-2.0.patch

	# Prevent sphinx-build to write python cache files where it might not have permisions
	sed -i 's/\$(SPHINX_BUILD)/-B $(SPHINX_BUILD)/' python{,3}/Makefile.in
}

src_configure() {
	if use java; then
		export CXXFLAGS="${CXXFLAGS} $(java-pkg_get-jni-cflags)"
	fi

	if use perl; then
		export PERL_ARCH="$(perl -MConfig -e 'print $Config{installvendorarch}')"
		export PERL_LIB="$(perl -MConfig -e 'print $Config{installvendorlib}')"
	fi

	if use lua; then
		export LUA_LIB="$($(tc-getPKG_CONFIG) --variable=INSTALL_CMOD lua)"
	fi

	local -x with_python2=without
	local -x with_python3=without

	check_python() {
		if [[ ${EPYTHON} == python3* ]]; then
			with_python3=with
		elif [[ ${EPYTHON} == python2* ]]; then
			with_python2=with
		fi
	}

	if use python; then
		python_foreach_impl check_python
	fi

	with_python="--${with_python2}-python --${with_python3}-python3"

	econf \
		--disable-documentation \
		$(use_with java) \
		$(use_with lua) \
		--without-csharp \
		$(use_with perl) \
		$(use_with php) \
		$with_python \
		$(use_with ruby) \
		$(use_with tcl)
#		$(use_with mono csharp)
}

src_compile() {
	local -x PYTHONDONTWRITEBYTECODE=
	default
}

src_install() {
	emake DESTDIR="${D}" install

	if use java; then
		java-pkg_dojar java/built/xapian_jni.jar
		# TODO: make the build system not install this...
		java-pkg_doso java/.libs/libxapian_jni.so
		rm -rf "${D}var" || die "could not remove java cruft!"
	fi

	use php && php-ext-source-r2_createinifiles

	# For some USE combinations this directory is not created
	if [[ -d "${D}/usr/share/doc/xapian-bindings" ]]; then
		mv "${D}/usr/share/doc/xapian-bindings" "${D}/usr/share/doc/${PF}" || die
	fi

	dodoc AUTHORS HACKING NEWS TODO README
}
