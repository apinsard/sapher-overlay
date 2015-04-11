# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"

PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.*"
inherit multilib python

DESCRIPTION="Simple tool to manage your package.use keeping track and comments on changes made."
HOMEPAGE="https://github.com/apinsard/chuse"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~*"
GITHUB_REPO="${PN}"
GITHUB_USER="apinsard"
GITHUB_TAG="${PV}"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/${GITHUB_TAG} -> chuse-${GITHUB_TAG}.tar.gz"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${GITHUB_USER}-${PN}"-??????? "${S}" || die
}

src_install() {
	into /usr/
	dosbin chuse
	doman man/man1/chuse.1
	dodoc ChangeLog README.md
}

src_compile() {
	return
}
