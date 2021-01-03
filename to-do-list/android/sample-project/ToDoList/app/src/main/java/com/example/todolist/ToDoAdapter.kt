package com.example.todolist

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import kotlinx.android.synthetic.main.list_item_main.view.*

class ToDoAdapter(
    private val context: Context,
    private val toDoList: List<ToDo>
): BaseAdapter() {

    // 表示するListに表示するためのレイアウトを取得する
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val v = convertView ?: LayoutInflater.from(context).inflate(R.layout.list_item_main, null)

        // ToDoの情報をまとめて取得する
        val toDo = toDoList[position]

        // タイトルに表示する内容を設定する。
        v.title_text.text = toDo.title

        // 作成日に表示する内容を設定する。
        v.registrationDate_text.text = toDo.registrationDate.toStrByAppDefStyle()

        // 期限日に表示する内容を設定する。
        v.limitDate_text.text = toDo.limitDate.toStrByAppDefStyle()

        // 優先度の表示の内容を設定する。
        // 優先度の星のimageViewをListで管理
        val priorityStars = listOf(
            v.star_1, v.star_2, v.star_3, v.star_4, v.star_5
        )


        return v
    }

    // 引数positionに相当する行の情報を取得
    override fun getItem(position: Int): ToDo {
        return toDoList[position]
    }

    // 引数positionに相当する行のIDを返却する（今回は使用しないため、0を返却)
    override fun getItemId(position: Int): Long {
        return 0
    }

    // 表示するリストの件数を返却する
    override fun getCount(): Int {
        return toDoList.size
    }

}



































