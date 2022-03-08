## CW

Coursework for module "Principles of Distributed Ledgers" for Imperial College of London.

## Instructions
Once you completed the contract, you can run 

`docker build -t tic-tac-toe .`

to build the tic-tac-toe docker image.


We provide several test cases to test the basic functions of your contract, which however is not complete as you are supposed to test your application through the UI and with MetaMask. You can anyways run 

`docker run tic-tac-toe npm test`

to check the incomplete test results and you are encouraged to extend the tests yourself, if you like. Our grading script will follow a similar methodology as the test script (i.e., to test your smart contract and grade based on the test results).

Prerequisite: please [install docker](https://docs.docker.com/desktop/) on your system.

To set up and play your tic-tac-toe game, you can:

1. start the ganache test chain

`docker run -p 8545:8545 -d trufflesuite/ganache-cli:latest -g 0`

2. start the web server

`docker run -p 8080:8080 -d tic-tac-toe`

3. open `http://localhost:8080/` in two separate web browsers with each a separate Metamask installed, and enjoy the game. On Chrome you can create **two different users** and install Metamask in each. You'll need to configure Metamask to connect to your local chain as well (which is not graded but we leave this up to you as part of the exercise for your own testing).
