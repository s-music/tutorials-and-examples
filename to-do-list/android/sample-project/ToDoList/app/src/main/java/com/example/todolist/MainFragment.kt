package com.example.todolist

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import kotlinx.android.synthetic.main.fragment_main.view.*

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

class MainFragment : Fragment() {
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
        val v = inflater.inflate(R.layout.fragment_main, container, false)

        (activity as? MainActivity)?.toDoList?.let {
            val toDoAdapter = ToDoAdapter(requireContext(), it)
            v.main_list_view.adapter = toDoAdapter

            // セルをタップした時のメソッド
            v.main_list_view.setOnItemClickListener { _, _, position, _ ->
                val action = MainFragmentDirections.actionMainFragmentToEditToDoFragment(
                    toDoAdapter.getItem(position), position
                )
                findNavController().navigate(action)
            }
        }
        // 画面を表示する際に、onCreateOptionsMenuメソッドを呼ぶ
        setHasOptionsMenu(true)

        return v
    }

    // MainFragment画面に menu/add_image の内容を取り入れる
    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.add_image, menu)
    }

    // 画面の上にあるアクションバーにあるMenuにあるitemが選択された場合に呼ばれるメソッド
    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {

            // add_image(+ボタン)が選択された場合、action_mainFragment_to_addToDoFragmentの画面遷移が走る
            R.id.add_image -> {
                findNavController().navigate(R.id.action_mainFragment_to_addToDoFragment)
                return true
            }
            else -> return super.onOptionsItemSelected(item)
        }
    }

    companion object {
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            MainFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }
}