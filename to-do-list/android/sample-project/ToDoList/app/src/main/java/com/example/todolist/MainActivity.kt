package com.example.todolist

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.inputmethod.InputMethodManager
import androidx.navigation.NavController
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    // 初期データの生成
    var toDoList: MutableList<ToDo> = mutableListOf(
        ToDo(title = "タイトル1", detail = "詳細1", priority = 1),
        ToDo(title = "タイトル2", detail = "詳細2", priority = 2),
        ToDo(title = "タイトル3", detail = "詳細3", priority = 3)
    )

    // findNavController(R.id.nav_host_fragment)を変数navController に統合
    private val navController: NavController by lazy {
        findNavController(R.id.nav_host_fragment)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // アプリ起動時、ToDoデータを読み込む
        loadToDoList()

        // アクションバーのセットアップ。
        val appBarConfiguration = AppBarConfiguration(navController.graph)
        setupActionBarWithNavController(navController, appBarConfiguration)

        // 画面を移動した際、キーボードを閉じる
        navController.addOnDestinationChangedListener { _, _, _ ->
            currentFocus?.let {
                val imm = getSystemService(AppCompatActivity.INPUT_METHOD_SERVICE) as InputMethodManager
                imm.hideSoftInputFromWindow(it.windowToken, InputMethodManager.HIDE_NOT_ALWAYS)

                main_layout.requestFocus()
            }
        }

    }

    // Upボタン(戻る)ボタンをタップした時に画面を戻る
    override fun onSupportNavigateUp() = navController.navigateUp()

    // アプリを閉じた時、現在のToDoListをデバイスに保存する
    fun saveToDoList() {
        val pref = getSharedPreferences("ToDoListApp", Context.MODE_PRIVATE)
        pref.edit().putString("ToDoList", Gson().toJson(toDoList)).apply()
    }

    // アプリ起動時、デバイスに保存されているToDoListを読み込む
    fun loadToDoList() {
        val pref = getSharedPreferences("ToDoListApp", Context.MODE_PRIVATE)
        pref.getString("ToDoList", null)?.let {
            val type = object : TypeToken<MutableList<ToDo>>() {}.type
            toDoList = Gson().fromJson<MutableList<ToDo>>(it, type)
        }
    }

}
