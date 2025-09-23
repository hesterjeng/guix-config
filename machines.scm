;; Use the necessary modules
(use-modules (guix)
             (guix.deploy)
             (guix.system)
             (guix.scm))

(specifications->deployment
 '("my-droplet")
 #:name "digitalocean-droplet"
 #:system
 (let ((host "root@138.197.45.28"))
   (deployment
    (hosts
     (list host))
    (operating-system
     (host-name "droplet")
     (timezone "UTC")
     (locale "en_US.UTF-8")
     (bootloader
      (bootloader-configuration
       (bootloader grub-bootloader)
       (target "/dev/vda"))) ;; DO default
     (file-systems
      (list (file-system
             (mount-point "/")
             (device "/dev/vda")
             (type "ext4"))))
     (users
      (list (user-account
             (name "root")
             (group "root")))) ;; <--- group required
     (packages
      (list bash git vim))
     (services
      (list (sshd-service)))))))
