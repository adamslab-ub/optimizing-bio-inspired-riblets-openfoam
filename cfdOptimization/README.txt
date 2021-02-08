In this code, it is assumed that the CFD-Riblet framework is running on a cluster (here CCR at University at Buffalo). You need to modify this address based on the system that runs the CFD-Riblet framework.
Based on the above assumption, you need to consider the following items:
- If you are using putty, it will be recommended to use "screen" to avoid losing your run.
- You need to have ssh-key to connect to CCR.
- Each time you make a new screen, you need to add ssh-key enabled by running "ssh_init.sh".