variable "debian_version" {
    default = "10.3.0"
}

source "vbox" "debian" {
    boot_command = [
        "<esc><wait>",
        "install <wait>",
        "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed_stretch.cfg <wait>",
        "debian-installer=en_US <wait>",
        "auto <wait>",
        "locale=en_US <wait>",
        "kbd-chooser/method=us <wait>",
        "keyboard-configuration/xkb-keymap=us <wait>",
        "netcfg/get_hostname={{ .Name }} <wait>",
        "netcfg/get_domain=vagrantup.com <wait>",
        "fb=false <wait>",
        "debconf/frontend=noninteractive <wait>",
        "console-setup/ask_detect=false <wait>",
        "console-keymaps-at/keymap=us <wait>",
        "<enter><wait>"
    ],
    boot_wait = "10s",
    disk_size = "32768",
    guest_aditions_path = "VBocGuestAdditions_{{.Version}}.iso",
    guest_os_type = "Debian_64",
    http_directory = "http",
    iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.3.0-amd64-xfce-CD-1.iso",
    iso_checksum_url = "http://cdimage.debian.org/cdimage/release/{{user `debian_version`}}/amd64/iso-cd/SHA512SUMS",
    iso_checksum_type = "sha512",
    ssh_username = "vagrant",
    ssh_password = "vagrant",
    ssh_port = "22",
    ssh_wait_timeout = "10000s",
    shutdown_command = "echo 'vagrant' | sudo -S shutdown -hP now"
    type = "virtualbox-iso",
    virtualbox_version_file = ".vbox_version",
    vm_name = "debian-{{user `debian_version`}}-amd64",
    # vboxmanage = [
    #    [ "modifyvm", "{{.Name}}", "--memory", "512" ]
    #    [ "modifyvm", "{{.Name}}", "--cpus", "1" ]
    #]
}

build {
    sources = [
        "source.vbox.debian"
    ]

    provisioner "shell" {
        inline = ["sleep 5"]
    }

    post-processor "shell-local" {
        inline = ["sleep 1"]
    }
}