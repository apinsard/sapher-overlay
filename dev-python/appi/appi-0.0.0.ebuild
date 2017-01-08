# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4..5} )

inherit distutils-r1

SRC_URI="https://github.com/apinsard/appi/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="Another Portage Python Interface"
HOMEPAGE="https://github.com/apinsard/appi/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
