package day3
import java.io.File

//the package name day2 is different from the file name day2. the file could be named anything and this would still work.
fun solve() {
  val lines: List<String> = File("in3.txt").readLines()
  val counts = IntArray(12)
  var total = 0
  lines.forEach {
    for (i in it.indices) {
        counts[i]+=it[i].code-'0'.code
    }
    total++
  }
  var gamma=0
  var epsilon=0
  var multiplier=1
  for (i in counts.indices) {
    if(counts[11-i]>total/2) {
      gamma+=multiplier
    } else {
      epsilon+=multiplier
    }
    multiplier*=2
  }
  println(gamma*epsilon)
}
fun solve2() {
  val lines: List<String> = File("in3.txt").readLines()
  fun reduceLines1(selectedLines: List<String>, position: Int): String {
    if(selectedLines.size==1)
      return selectedLines[0]
    var count=0//count of 1's
    var total=0
    val partition = arrayOf(mutableListOf<String>(),mutableListOf<String>())
    selectedLines.forEach {
      val bitVal = it[position].code-'0'.code
      count+=bitVal
      partition[bitVal].add(it)
      total++
    }
    // println("${partition[0][0]},${partition[1][0]}")
    println("${count}, ${total}, ${partition[0].size}, ${partition[1].size}")
    var index=0
    if(count>=total-count)
      index=1
    // println(index)
    return reduceLines1(partition[index],position+1)
  }
  fun reduceLines2(selectedLines: List<String>, position: Int): String {
    if(selectedLines.size==1)
      return selectedLines[0]
    var count=0//count of 1's
    var total=0
    val partition = arrayOf(mutableListOf<String>(),mutableListOf<String>())
    selectedLines.forEach {
      val bitVal = it[position].code-'0'.code
      count+=bitVal
      partition[bitVal].add(it)
      total++
    }
    // println("${partition[0][0]},${partition[1][0]}")
    var index=0
    if(count<total-count)
      index=1
    // println(index)
    return reduceLines2(partition[index],position+1)
  }
  val values = arrayOf<Int>(0,0)
  val bs1=  reduceLines1(lines,0)
  println("----")
  val bs = arrayOf<String>(bs1,reduceLines2(lines,0))
  for(i in values.indices) {
    var multiplier = 1
    for(j in bs[i].indices.reversed()) {
      if(bs[i][j]=='1')
        values[i]+=multiplier
      multiplier*=2
    }
  }
  println("${bs[0]},${bs[1]}")
  println("${values[0]},${values[1]}")
  println(values[0]*values[1])
}