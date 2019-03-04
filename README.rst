stx-tis-repo
============

This repo is being used for development of DevStack plugins
for StarlingX flock services.  It is not used in the build
or operation of StarlingX in any way in spite of it having
that resembles a historical repo for this project.

The reason for doing this separate form the service plugins
is that there are some interesting dependencies between the
plugins and the base stx devstack job should be not in one of
the service repos.
