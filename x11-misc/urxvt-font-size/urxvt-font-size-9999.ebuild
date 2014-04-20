# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit multilib

DESCRIPTION="Perl extensions for changing the font-size on the fly"
HOMEPAGE="https://github.com/majutsushi/urxvt-font-size"
SRC_URI="https://github.com/majutsushi/${PN}/archive/master.zip -> {P}.zip"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-terms/rxvt-unicode[perl]"
S="${WORKDIR}/${PN}-master"

src_install() {
	insinto /usr/$(get_libdir)/urxvt/perl
	doins font-size
	dodoc README.markdown
}
