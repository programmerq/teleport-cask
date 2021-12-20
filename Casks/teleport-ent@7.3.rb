cask "teleport-ent" do
  version "7.3.8"
  sha256 "238ac685947751f3a7efc063ef8b21cb8c4f493ec000442fa5c2e3954fe4872e"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.0"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
