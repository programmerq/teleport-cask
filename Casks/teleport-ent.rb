cask "teleport-ent" do
  version "9.1.1"
  sha256 "5709ff11228cb197cd0b5ab9e9690d84484d9a06c8e2626df62072847a830dcc"

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
