cask "teleport-ent@7.0" do
  version "7.0.3"
  sha256 "fe199036e75909575352f1186ad5d2826200736714e6e9d2a3ce1a9ecc84b4be"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
