# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Offers quick access to files and directories, inspired by autojump, z and v"
HOMEPAGE="http://github.com/clvv/fasd"
SRC_URI="https://github.com/clvv/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	true
}

src_install() {
	dobin fasd
	doman fasd.1
}

pkg_postinst() {
	einfo "Put the line below in your shell rc"
	einfo "eval \"\$(fasd --init auto)\""
	einfo "More information on setting up fasd and customizing it"
	einfo "can be found in the man page"
}
