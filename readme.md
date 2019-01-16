Lab exercises for Language Processors 2018/2019
===============================================

This repository contains the specifications for the three lab exercises for Language Processors.

The three exercises are:

1 - [Lexers and regular expressions](1-regexes) (due Tue 29 Jan at 23:59).

2 - [Parsers and ASTs](2-parsers) (due Tue 12 Feb at 23:59).

3 - [Code Generation](3-codegen) (due Tue 26 Feb at 23:59).

The primary purpose of the lab exercises is to ensure that everyone learns the basic skills needed for the coursework. They are not designed to be too challenging, but they do require you to get to grips with several tools and concepts that you will need later.


Assessment and Feedback
=======================

The three exercises are equally weighted, and are together worth 33.3% of your computing lab mark.

The exercises will be marked in a largely automated fashion. I will compile your code and run it against a collection of my own inputs. Please note that it is very important to test that your code compiles and runs correctly. Failure to do so could result a mark of zero for that exercise.

Feedback will be largely in terms of what works and what doesn't work. I hope to provide formal feedback within ten working days. You are also encouraged to seek informal feedback on your code from the teaching assistant, your tutor, and your peers.


Environment
===========

The target environment for the labs (and the coursework) is Ubuntu 16.04. It is strongly suggested that you do your final testing before each submission in this environment, otherwise you are likely to hit incompatibility problems, which may mean your program won't build. Those using Mac OS should watch out in particular, as the build environment is often subtly different.

If you want to work on your own machine (which is encouraged), you can install a version of Ubuntu quite easily. For this, you may wish to use [VirtualBox](https://www.virtualbox.org/) together with [Vagrant](https://www.vagrantup.com/).

This repository contains a [Vagrantfile](Vagrantfile), which is a script that sets up a blank Ubuntu 16.04 environment, and then installs all the tools that the lab exercises require. To start a virtual machine (VM) using Vagrant, follow these steps.

- Open a shell in this directory.

- Run `vagrant up` to download, install, and configure the VM.

- Run `vagrant ssh` to log into the VM.

- Run `cd /vagrant` : This will put you in the same directory, with
  your host files shared with the VM.

You can then use command line build tools in the VM, while editing
the source files in your host editor.

If you want to stop the machine,

- Run `exit` to exit the session,

- Run `vagrant halt` to shut down the virtual machine.

If you later run `vagrant up` again, it will not need to download the VM from scratch.


Setting up your `git` repository
================================

A private repository has been created for you, which you can clone using the following command:
````
git clone https://github.com/LangProc/langproc-2018-lab-${LOGIN}.git
````
You'll need to type in your GitHub credentials to authenticate, unless
you've set up SSH authentication.

You are free to include any files you wish in your repository, such as notes or partial versions. However, try not check in compiled programs or large binary files. Repositories should contains the sources and instructions for binaries, but `git` does not deal well with binary files. Most repositories should contain a [.gitignore](https://git-scm.com/docs/gitignore) file, which gives patterns for files that should not be committed. There is [one included here](.gitignore) which covers a few things, but feel free to add other temporary and binary files that your system might produce.

Synchronising with the specification repository
-----------------------------------------------

If there are any changes to the specification (e.g. bugs or updates), you can incorporate them into your version by pulling again from the specification repo. First you need to make sure it is included as a "remote":
````
git remote add spec https://github.com/LangProc/langproc-2018-lab.git
````
If you now list the remotes, you should see both "origin" (your private repo), and "spec" (the specification repo):
````
git remote -v
````
You can now integrate changes from the specification repo by pulling from it:
````
git pull spec master
````

If you have changed a file that also changed in the specification, then you may need to commit locally first. Look carefully at any incoming changes due to the pull, and make sure you want to accept them.

Submission process
==================

Submission of code is via your `git` repository. Make sure you have committed and pushed to GitHub all the files that your project needs. You are _strongly_ encouraged to clone it into a different directory and then test again, just in case you are relying on something that wasn't committed.

Once your code is committed, note the [commit hash](https://blog.thoughtram.io/git/2014/11/18/the-anatomy-of-a-git-commit.html)
of your current revision:

````
git log -1
````
This will produce something like:
````
ubuntu@ubuntu-xenial:/vagrant$ git log -1
commit 94d8419b20c78da86415bea7236d3719915977a3
Author: John Wickerson <j.wickerson@imperial.ac.uk>
Date:   Mon Jan 07 14:26:40 2018 +0000

    All tests passing.
````

The commit hash of this revision is `94d8419b20c78da86415bea7236d3719915977a3`
which is a cryptographic hash over all the files in your
repository, including the history of all the files. The hash produced
on your local machine will also match the hash calculated
by GitHub.

So take your hash (and just the hash), and submit it via Blackboard.  Even if GitHub goes down, you can later on prove that the existence of your hash in Blackboard means you must have done the work associated with the hash.  The hash in Blackboard will also be the exact revision of your repository that will get checked out of GitHub and tested. So you can carry on editing and modifying the repository, but only the commit with the hash submitted to Blackboard will be tested.

To summarise:

1. Test your code on your machine.

2. Commit your code to your local repo.

3. Note the commit hash (`git log -1`).

4. Push the code to GitHub.

5. Check that the commit hash in the GitHub website matches your local hash.

6. **Strongly recommended**: clone your code to a completely different directory,
    and test it again.

7. Submit the hash via Blackboard.

You can repeat this process as many times as you want, up until the deadline.

Acknowledgements
================

The exercises were devised by Dr David Thomas (course lecturer until 2017-18), and are nowadays maintained by Dr John Wickerson.
