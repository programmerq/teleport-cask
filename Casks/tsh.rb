cask "tsh" do
  version "9.3.3"
  sha256 "056a8025a8b05a976263fbfeca7c6e85f8703b3d78d277155ec06ae31e87419f"

  url "https://get.gravitational.com/tsh-#{version}.pkg",
      verified: "get.gravitational.com"
  name "tsh"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. TSH client only"
  homepage "https://goteleport.com/"
  pkg "tsh-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport.tsh"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "teleport", "teleport-ent@7.0", "teleport-ent@7.1", "teleport-ent@7.2", "teleport-ent@7.3","teleport-ent@8.0"]

  caveats do
    license "Apache-2.0"
  end
end
