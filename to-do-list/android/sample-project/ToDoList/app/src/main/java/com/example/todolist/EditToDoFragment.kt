package com.example.todolist

import android.app.DatePickerDialog
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import android.widget.ImageView
import android.widget.SeekBar
import android.widget.TextView
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import kotlinx.android.synthetic.main.fragment_to_do_form.*
import kotlinx.android.synthetic.main.fragment_to_do_form.view.*
import java.util.*

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

class EditToDoFragment : Fragment() {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null

    // 引数をnavArgs()でまとめて受け取り、変数argsにひとまとめ
    private val args: EditToDoFragmentArgs by navArgs()

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
        val v = inflater.inflate(R.layout.fragment_to_do_form, container, false)
        val textBufferType = TextView.BufferType.EDITABLE

        // タイトルの設定
        v.title_edit_text.setText(args.toDo.title, textBufferType)

        // 期限日の設定
        v.limit_date_edit_text.setText(args.toDo.limitDate.toStrByAppDefStyle(), textBufferType)

        // 期限日のEditTextがタップされた時にDatePickerDialogを出す処理
        v.limit_date_edit_text.setOnClickListener {
            val showDate = v.limit_date_edit_text.text.toString().toCalByAppDefStyle() ?: Calendar.getInstance()
            DatePickerDialog(
                requireActivity(),
                DatePickerDialog.OnDateSetListener { _, year, month, dayOfMonth ->
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

        // 星のImageViewをList化
        val priorityStars = listOf(
            v.priority_image1, v.priority_image2, v.priority_image3, v.priority_image4, v.priority_image5
        )

        // 星のイメージの表示・非表示を設定
        setPriority(priorityStars, args.toDo.priority)

        // SeekBarの設定
        v.priority_seek_bar.progress = args.toDo.priority - 1

        // SeekBarの値が変更された時の処理を設定
        v.priority_seek_bar.setOnSeekBarChangeListener(object: SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar, progress: Int, fromUser: Boolean) {
                setPriority(priorityStars, progress + 1)
            }
            override fun onStartTrackingTouch(seekBar: SeekBar?) {}
            override fun onStopTrackingTouch(seekBar: SeekBar) {}
        })

        // 詳細の設定
        v.detail_edit_text.setText(args.toDo.detail, textBufferType)

        // アクションバーにMenuを表示するよう設定
        setHasOptionsMenu(true)

        return v
    }

    // 優先度imageの設定
    private fun setPriority(imageList: List<ImageView>, priority: Int) {
        for(i in 0 until imageList.size) {
            val visible = if (i < priority) View.VISIBLE else View.INVISIBLE
            imageList[i].visibility = visible
        }
    }

    // アクションバーに表示するMenuを設定
    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.save, menu) // saveボタンを追加
        inflater.inflate(R.menu.delete, menu) // deleteボタンを追加
    }

    // 編集画面を閉じる時(saveボタン)をタップした時の動作
    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        // activity as? MainActivityを変数mainActivity にまとめる
        val mainActivity = activity as? MainActivity

        when (item.itemId) {
            // saveボタンをタップした時の動作
            R.id.save -> {
                // args.toDoを編集しListを保存する
                args.toDo.title = title_edit_text.text.toString()
                args.toDo.registrationDate = Calendar.getInstance()
                args.toDo.limitDate = limit_date_edit_text.text.toString().toCalByAppDefStyle() ?: Calendar.getInstance()
                args.toDo.priority = priority_seek_bar.progress + 1
                args.toDo.detail = detail_edit_text.text.toString()
                mainActivity?.saveToDoList()

                // 前の画面に戻る
                findNavController().navigateUp()

                return true
            }

            // deleteボタンをタップした時の動作
            R.id.delete -> {
                mainActivity?.let {
                    // ToDoを削除してListを保存する
                    it.toDoList.removeAt(args.index)
                    it.saveToDoList()

                    // 前の画面に戻る
                    findNavController().navigateUp()
                }
                return true
            }

            else -> return super.onOptionsItemSelected(item)
        }
    }

    companion object {
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            EditToDoFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }
}