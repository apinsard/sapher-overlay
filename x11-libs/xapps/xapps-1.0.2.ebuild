# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools

SRC_URI="https://github.com/linuxmint/xapps/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="Cross-desktop libraries and common ressources"
HOMEPAGE="https://github.com/linuxmint/xapps/"

LICENSE="LGPL-3"
SLOT="0"

RDEPEND="
>=x11-libs/gdk-pixbuf-2.22.0:2[introspection]
>=x11-libs/gtk+-3.3.16:3[introspection]
>=dev-libs/glib-2.37.3:2
x11-libs/cairo
gnome-base/libgnomekbd
"
DEPEND="${RDEPEND}"

src_prepare() {
	rm -rf files/usr/bin
	eautoreconf
}
