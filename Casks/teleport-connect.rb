cask "teleport-connect" do
  module Utils
    def self.version
      return "15.1.4"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://get.gravitational.com/Teleport Connect-#{version}.dmg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://get.gravitational.com/Teleport Connect-#{version}.dmg",
      verified: "get.gravitational.com"
  name "Teleport Connect"
  desc "Teleport Connect is a user-friendly GUI desktop application that provides the same access to servers, databases, and Kubernetes clusters as the Teleport command-line client (tsh)."
  homepage "https://goteleport.com/"
  app "Teleport Connect.app"

  uninstall quit: "gravitational.teleport.connect"

  caveats do
    license "AGPL-3.0"
  end
end
