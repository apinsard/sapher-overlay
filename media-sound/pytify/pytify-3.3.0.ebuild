# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )
DISTUTILS_SINGLE_IMPL=yes

inherit distutils-r1

SRC_URI="https://github.com/bjarneo/${PN^}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="A CLI application for controlling Spotify"
HOMEPAGE="https://github.com/bjarneo/${PN^}"

LICENSE="MIT"
SLOT="0"
IUSE=""

REQUIRED_USE=""

CDEPEND="
	>=dev-python/requests-2.4.3[${PYTHON_USEDEP}]
	=dev-python/prompt_toolkit-1.0.0[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
"
RDEPEND="${CDEPEND}
	media-sound/spotify
"
DEPEND="${CDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${P^}"

src_prepare() {
	# Fix missing pytify.dbus module issue, should be fixed in next version
	sed -i "s/packages=\(.*\),/packages=['pytify', 'pytify.dbus'],/" setup.py
	# Fix bugged pytify.dbus module, should be fixed in next version
	sed -i "s/^import dbus$/import dbus, sys/" pytify/dbus/interface.py
	distutils-r1_src_prepare
}
