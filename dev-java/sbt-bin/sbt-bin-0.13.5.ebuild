# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker

MY_PN=${PN%-bin}
DESCRIPTION="sbt is a build tool for Scala, Java, and more."
HOMEPAGE="http://www.scala-sbt.org/"
SRC_URI="http://dl.bintray.com/${MY_PN}/debian/${MY_PN}-${PV}.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=virtual/jre-1.6"

src_unpack() {
	unpack_deb ${A}
	rm -rf etc >/dev/null
	mkdir ${P}
	mv usr ${P}
}

src_install() {
	dodoc usr/share/doc/${MY_PN}/*
	doman usr/share/man/man1/${MY_PN}.1.gz
	insinto /usr/share/${MY_PN}/bin
	doins usr/share/sbt-launcher-packaging/bin/*
	fperms +x /usr/share/${MY_PN}/bin/${MY_PN}
	dosym ../share/${MY_PN}/bin/${MY_PN} /usr/bin/${MY_PN}
	insinto /etc/${MY_PN}
	doins usr/share/sbt-launcher-packaging/conf/*
}
