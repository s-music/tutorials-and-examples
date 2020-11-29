package com.example.todolist

import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.*

// CalendarをString型に変換するメソッド
fun Calendar.toStrByAppDefStyle(): String {
    return SimpleDateFormat("yyyy-MM-dd", Locale.US).format(this.time)
}

// StringをCalendar型に変換するメソッド
fun String.toCalByAppDefStyle(): Calendar? {
    try {
        val cal = Calendar.getInstance()
        cal.time = SimpleDateFormat("yyyy-MM-dd", Locale.US).parse(this)
        return cal
    } catch(_: ParseException) {
        return null
    }
}
