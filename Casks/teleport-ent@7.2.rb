cask "teleport-ent" do
  version "7.2.1"
  sha256 "a6eacbb49603d8953ac4fb539c4faf8e0cc5c3408fa34201b410654f0a2c1a5a"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.0", "teleport-ent@7.1"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
