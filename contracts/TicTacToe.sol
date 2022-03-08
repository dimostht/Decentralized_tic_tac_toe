//SPDX-License-Identifier: Unlicense
pragma solidity ^0.4.24;

/**
 * @title TicTacToe contract
 **/
contract TicTacToe {
    address[2] public players;

    /**
     turn
     1 - players[0]'s turn
     2 - players[1]'s turn
     */
    uint public turn = 1;

    /**
     status
     0 - ongoing
     1 - players[0] won
     2 - players[1] won
     3 - draw
     */
    uint public status;

    /**
    board status
     0    1    2
     3    4    5
     6    7    8
     */
    uint[9] private board;

    /**
      * @dev Deploy the contract to create a new game
      * @param opponent The address of player2
      **/
    constructor(address opponent) public {
        require(msg.sender != opponent, "No self play");
        players = [msg.sender, opponent];
    }

    /**
      * @dev Check a, b, c in a line are the same
      * _threeInALine doesn't check if a, b, c are in a line
      * @param a position a
      * @param b position b
      * @param c position c
      **/    
    function _threeInALine(uint a, uint b, uint c) private view returns (bool){
        return (board[a] == board[b]) && (board[a] == board[c]);
    }

    /**
     * @dev get the status of the game
     * @param pos the position the player places at
     * @return the status of the game
     */
    function _getStatus(uint pos) private view returns (uint) {
        function _getStatus(uint pos) private view returns (uint) {
        // horizontal or vertical win
        uint r = pos / 3;
        uint c = pos % 3;
        bool win1 = _threeInALine(board[r * 3], board[r * 3 + 1], board[r * 3 + 2]);
        bool win2 = _threeInALine(board[c], board[c + 3], board[c + 6]);

        // diagonal win one
        bool win3 = _threeInALine(board[0], board[4], board[8]);

        // diagonal win two
        bool win4 = _threeInALine(board[2], board[4], board[6]);

       // there is a win
        bool win = (win1 || win2 || win3 || win4);

        // last player wins
        if (win){
          return board[pos];
        }

        // no winner and no empty cell means draw
        bool draw = true;
        for (uint i=0; i < board.length; i++) {
          if (board[i] == 0) {
            draw = false;
          }
        }
        if (draw)
          return 3;

        // ongoing
        return 0;
    }

    /**
     * @dev ensure the game is still ongoing before a player moving
     * update the status of the game after a player moving
     * @param pos the position the player places at
     */
    modifier _checkStatus(uint pos) {
        require(status == 0);
        _;
    }

    /**
     * @dev check if it's msg.sender's turn
     * @return true if it's msg.sender's turn otherwise false
     */
    function myTurn() public view returns (bool) {
       if (msg.sender == players[0]){
        return turn == 1;
      }
      else if (msg.sender == players[1]){
        return turn == 2;
      }
      return false;
    }

    /**
     * @dev ensure it's a msg.sender's turn
     * update the turn after a move
     */
    modifier _myTurn() {
      require(myTurn());
      _;
      if (turn == 1){
        turn = 2;
      }
      else if (turn == 2){
        turn = 1;
      }
    }

    /**
     * @dev check a move is valid
     * @param pos the position the player places at
     * @return true if valid otherwise false
     */
    function validMove(uint pos) public view returns (bool) {
      return board[pos] == 0;
    }

    /**
     * @dev ensure a move is valid
     * @param pos the position the player places at
     */
    modifier _validMove(uint pos) {
      require(validMove(pos));
      _;
    }

    /**
     * @dev a player makes a move
     * @param pos the position the player places at
     */
    function move(uint pos) public _validMove(pos) _checkStatus(pos) _myTurn {
        board[pos] = turn;
    }

    /**
     * @dev show the current board
     * @return board
     */
    function showBoard() public view returns (uint[9]) {
      return board;
    }
}
