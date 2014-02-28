# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 user

MY_PN="${PN%-bin}"
MY_P="${MY_PN}-${PV}"
MY_PF="${MY_PN}-${PVR}"

DESCRIPTION="An open source distributed database management system designed to
handle large amounts of data"
HOMEPAGE="http://cassandra.apache.org/"
SRC_URI="mirror://apache/${MY_PN}/${PVR}/apache-${MY_PN}-${PVR}-bin.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
JAVA_PKG_IUSE="doc"
IUSE="doc +jna"

DEPEND=""
RDEPEND="virtual/jre:1.7
	jna? ( >=dev-java/jna-3.4.0 )"

S=${WORKDIR}/apache-${MY_PF}

pkg_setup() {
	enewgroup ${MY_PN} || die "Could not create group"
	enewuser ${MY_PN} -1 /bin/bash /var/lib/${MY_PN} ${MY_PN}
}

src_prepare() {
	epatch "${FILESDIR}/${MY_PN}-fix-path.patch"
}

src_install() {
	dodir /etc/${MY_PN}
	insinto /etc/${MY_PN}
	doins -r conf/*

	insinto /usr/share/${MY_PN}/lib
	( use jna ) && java-pkg_jar-from jna jna.jar lib/jna.jar || die "could not symlink jna"
	doins -r lib/*

	insinto /usr/share/${MY_PN}
	doins bin/cassandra.in.sh

	keepdir /var/lib/${MY_PN}
	dodir /var/log/${MY_PN}

	fowners -R ${MY_PN}:${MY_PN} /var/{log,lib}/${MY_PN} || die "chown /var/log/${MY_PN} failed"

	rm bin/*.bat || die "rm .bat files failed"
	rm bin/{cqlsh,debug-cql,cassandra.in.sh} || die "rm failed"
	dobin bin/*

	newinitd "${FILESDIR}/${MY_PN}.init" "${MY_PN}"
	newconfd "${FILESDIR}/${MY_PN}.conf" "${MY_PN}"

	insinto /etc/security/limits.d
	doins "${FILESDIR}/90-${MY_PN}.conf"

	use doc && (java-pkg_dojavadoc javadoc/ || die "dojavadoc failed")
}

pkg_postinst() {
	elog "Cassandra Configuration:"
	elog "  Runtime: /usr/share/cassandra.in.sh"
	elog "  Startup: /etc/conf.d/cassandra"
	elog
	ewarn "You should start/stop cassandra via /etc/init.d/cassandra, as this will properly switch to the cassandra:cassandra user group"
	ewarn "Starting cassandra via its default 'cassandra' shell command, may cause permission problems later on when started as the cassandra user"
}
