# Distributed under the terms of the GNU General Public License v2

EAPI=6

BRAVE_PN="${PN/-bin}"

inherit eutils

DESCRIPTION="Brave Web Browser"
HOMEPAGE="https://brave.com"
LICENSE="MPL-2.0"
SLOT=0
KEYWORDS="~*"
SRC_URI="https://github.com/brave/browser-laptop/releases/download/v${PV}dev/Brave.tar.bz2 -> ${P}.tar.bz2"
RESTRICT="strip mirror"

IUSE=""

RDEPEND="gnome-base/libgnome-keyring"
DEPEND="${RDEPEND}
	gnome-base/gconf
"

S="${WORKDIR}/Brave-linux-x64"

src_install() {
	declare BRAVE_HOME=/opt/${BRAVE_PN}

	insinto /usr/share/icons/hicolor/128x128/apps
	newins "${S}/resources/extensions/brave/img/braveAbout.png" "${PN}.png" || die
	newicon "${S}/resources/extensions/brave/img/braveAbout.png" "${PN}.png"
	domenu "${FILESDIR}"/${PN}.desktop

	dodir ${BRAVE_HOME%/*}
	mv "${S}" "${ED}"${BRAVE_HOME} || die

	# Create /usr/bin/brave-bin
	dodir /usr/bin/
	cat <<-EOF >"${ED}usr/bin/${PN}"
	#!/bin/sh
	unset LD_PRELOAD
	LD_LIBRARY_PATH="${BRAVE_HOME}/"
	exec ${BRAVE_HOME}/${BRAVE_PN} "\$@"
	EOF
	chmod 0755 "${ED}usr/bin/${PN}"

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=${BRAVE_HOME}" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die
}
