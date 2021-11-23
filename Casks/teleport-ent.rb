cask "teleport-ent" do
  version "7.3.3"
  sha256 "2a8c0b0fc5316ddc2f0da5df5e5a4f2fa53a291b31e0b9fce6ae6482d0183f4f"

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
