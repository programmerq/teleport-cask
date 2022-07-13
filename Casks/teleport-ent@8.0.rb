cask "teleport-ent@8.0" do
  version "8.3.15"
  sha256 "0d33acc232d268e51fecc754c2088e92ce5ce0c454fe6cfbd54f1cb947d99b6e"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.0", "teleport-ent@7.1", "teleport-ent@7.2", "teleport-ent@7.3"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
