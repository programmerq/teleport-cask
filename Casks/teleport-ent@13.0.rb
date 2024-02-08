cask "teleport-ent@13.0" do
  module Utils
    def self.version
      return "13.4.16"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://get.gravitational.com/teleport-ent-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "teleport-ent@14.0", "teleport-ent@12.0", "teleport-ent"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
