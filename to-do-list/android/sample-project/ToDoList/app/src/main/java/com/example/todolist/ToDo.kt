package com.example.todolist

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize
import java.util.*

// Edit画面への遷移時に引数として渡すためにParcelableを継承する
@Parcelize
data class ToDo(
    var title: String = "タイトルなし",
    var detail: String = "",
    var priority: Int = 0,
    var limitDate: Calendar = Calendar.getInstance(),
    var registrationDate: Calendar = Calendar.getInstance()
): Parcelable
