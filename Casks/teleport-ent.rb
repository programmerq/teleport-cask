cask "teleport-ent" do
  version "9.1.2"
  sha256 "a8ead08ae9b1335aa30d2ccc69b74e45750afc169f30a270a0490499e142d605"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.0", "teleport-ent@7.1", "teleport-ent@7.2", "teleport-ent@7.3", "teleport-ent@8.0"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
