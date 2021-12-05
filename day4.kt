package day4

import java.io.File

fun solve() {
  val lines: List<String> = File("in4.txt").readLines()
  val numBoards = (lines.size-1)/6
  val numsDrawn: List<Int> = lines[0].split(",").map({it.toInt()})
  val bingoBoards = Array(numBoards) {Array(10) {mutableListOf<Int>()}}
  //first 5 are rows, second 5 are columns.
  for (i in 1..lines.size-1) {
    // println(lines[i])
    if ((i-1)%6==0)
      continue
    else {
      // println(i)
      val row = lines[i].split(" ").filter{it!=""}.map({it.toInt()})
      // println("${lines[i]}|")
      val boardNum = (i-2)/6
      bingoBoards[boardNum][(i-2)%6] = row.toMutableList()
      for (j in 1..5) {
        bingoBoards[boardNum][4+j].add(row[j-1])
      }
    }
  }
  var numWinners = 0
  val alreadyWon = Array(numBoards) {false}
  for (number in numsDrawn) {
    bingoBoards.forEachIndexed { index, board ->
      if(!alreadyWon[index]) {
        for (line in board) {
          line.remove(number)
          if (line.size==0) {
            alreadyWon[index]=true
            println(numWinners)
            numWinners++
            break
          }
        }
        if(numWinners==numBoards) {
          var sum = 0
          for (lineIndex in 0 until 5) {
            sum += board[lineIndex].sum()
          }
          println("${index}:${number*sum}")
        }
      }
    }
  }
  
  
}