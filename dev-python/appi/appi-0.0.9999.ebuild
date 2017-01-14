# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4..5} )

inherit distutils-r1 git-r3

APPI_VERSION=${PV%.*}

SRC_URI=""
EGIT_REPO_URI="git://github.com/apinsard/appi.git"
EGIT_BRANCH="${APPI_VERSION}"
KEYWORDS=""

DESCRIPTION="Another Portage Python Interface"
HOMEPAGE="https://github.com/apinsard/appi/"

LICENSE="GPL-2"
SLOT="0/${APPI_VERSION}"
IUSE=""

REQUIRED_USE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
