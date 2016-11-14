# e

TODO: Enter the cookbook description here.

Q)Using 'Test Kitchen', show how can a DevOps test his recipes without a need of uploading a cookbook on server and executing it on nodes. 
Ans)

kitchen init inside your cookbook to initialize kitchen => this creates a kitchen.yml where the OS required for vagrant , path for environment,roles, run-list, etc. can be specified.

kitchen create to download/use the downloaded os image with any provider(Ex. Virtual Box).

kitchen converge to test the recipes on your vagrant machine.

kitchen destroy to stop the vagrant/kitchen create, this will not delete the box.
