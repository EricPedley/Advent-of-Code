package day2
import java.io.File

//the package name day2 is different from the file name day2. the file could be named anything and this would still work.
fun solve() {
  val lines: List<String> = File("in2.txt").readLines()
  var horizontal: Int = 0
  var vertical: Int = 0
  lines.forEach {
    val (instruction, valueString) = it.split(' ')
    val value = valueString.toInt()
    when(instruction) {
      "forward"-> horizontal+=value
      "down"->vertical+=value
      "up"->vertical-=value
    }
  }
  println(horizontal*vertical)
}
fun solve2() {
  val lines: List<String> = File("in2.txt").readLines()
  var horizontal: Int = 0
  var vertical: Int = 0
  var aim: Int=0
  lines.forEach {
    val (instruction, valueString) = it.split(' ')
    val value = valueString.toInt()
    when(instruction) {
      "forward"-> {
        horizontal+=value
        vertical+=aim*value
      }
      "down"->aim+=value
      "up"->aim-=value
    }
  }
  println(horizontal*vertical)
}