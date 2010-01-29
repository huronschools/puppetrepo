# /etc/puppet/manifests/site.pp

import "modules"
import "classes/*"
import "nodes"
import "users/*"
import "templates"

# The filebucket option allows for file backups to the server
filebucket { main : server => 'testing.huronhs.com' }

# Set global defaults - paths
File { backup => main}
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin"}
