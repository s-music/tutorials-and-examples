package com.example.todolist

import android.app.DatePickerDialog
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import android.widget.SeekBar
import android.widget.TextView
import androidx.navigation.fragment.findNavController
import kotlinx.android.synthetic.main.fragment_to_do_form.*
import kotlinx.android.synthetic.main.fragment_to_do_form.view.*
import java.util.*

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

class addToDoFragment : Fragment() {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
            param2 = it.getString(ARG_PARAM2)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // AddToDoFragmentとして表示するviewを取得
        val v = inflater.inflate(R.layout.fragment_to_do_form, container, false)

        // 期限textがタップされた時に行われる処理を設定
        v.limit_date_edit_text.setOnClickListener {

            // DatePickerDialogというAndroid標準のカレンダーダイアログを作成して表示する処理
            val showDate = v.limit_date_edit_text.text.toString().toCalByAppDefStyle() ?: Calendar.getInstance()
            DatePickerDialog(
                requireActivity(),

                // カレンダーダイアログを確定した時に行われる処理を設定
                DatePickerDialog.OnDateSetListener { _, year, month, dayOfMonth ->
                    // 選択した日付を期限textに設定
                    val selectedDate = Calendar.getInstance()
                    selectedDate.set(year, month, dayOfMonth)
                    v.limit_date_edit_text.setText(
                        selectedDate.toStrByAppDefStyle(),
                        TextView.BufferType.EDITABLE
                    )
                },
                showDate.get(Calendar.YEAR),
                showDate.get(Calendar.MONTH),
                showDate.get(Calendar.DATE)

            ).show()
        }

        // seekBarの値が変更された時のListenerを優先度seekBarに設定
        v.priority_seek_bar.setOnSeekBarChangeListener(object: SeekBar.OnSeekBarChangeListener {
            // 優先度seekBarの値が変更されたらその値に応じて表示する星マークを制御
            override fun onProgressChanged(seekBar: SeekBar, progress: Int, fromUser: Boolean) {
                val priorityStars = arrayOf(
                    v.priority_image1, v.priority_image2, v.priority_image3, v.priority_image4, v.priority_image5
                )
                val priority = progress + 1
                for(i in 0 until priorityStars.size) {
                    val visible = if (i < priority) View.VISIBLE else View.INVISIBLE
                    priorityStars[i].visibility = visible
                }
            }
            override fun onStartTrackingTouch(seekBar: SeekBar?) {}
            override fun onStopTrackingTouch(seekBar: SeekBar) {}
        })

        // 画面表示する時、関数onCreateOptionsMenu を呼ぶ
        setHasOptionsMenu(true)

        return v
    }

    // ToDoの追加画面、メニューバーにaddクラスのボタンを追加する
    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.add, menu)
    }

    // ヘッダーメニューが選択された場合の挙動を設定
    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.add -> {
                // 入力された値を元にToDoデータを作成し、Listに追加する
                (activity as? MainActivity)?.let { // (activity as? MainActivity)をまとめる
                    val toDo = ToDo()
                    toDo.title = title_edit_text.text.toString()
                    toDo.registrationDate = Calendar.getInstance()
                    toDo.limitDate = limit_date_edit_text.text.toString().toCalByAppDefStyle() ?: Calendar.getInstance()
                    toDo.priority = priority_seek_bar.progress + 1
                    toDo.detail = detail_edit_text.text.toString()
                    it.toDoList.add(toDo)
                    it.saveToDoList()
                }

                // 前の画面に戻る
                findNavController().navigateUp()

                return true
            }
            else -> return super.onOptionsItemSelected(item)
        }
    }


    companion object {
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
                addToDoFragment().apply {
                    arguments = Bundle().apply {
                        putString(ARG_PARAM1, param1)
                        putString(ARG_PARAM2, param2)
                    }
                }
    }
}