cask "teleport-ent" do
  version "8.1.0"
  sha256 "5f9a307ae7d240480556ae9077e9e70e29051bca907d2de10195bad75c764b17"

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
