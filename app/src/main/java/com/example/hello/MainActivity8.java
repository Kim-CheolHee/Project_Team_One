package com.example.hello;

import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;

import androidx.appcompat.app.AppCompatActivity;

import com.example.hello.databinding.Activity8MainBinding;

public class MainActivity8 extends AppCompatActivity {

    CheckBox[] checkBoxes;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 뷰 바인딩 객체 획득
        Activity8MainBinding binding = Activity8MainBinding.inflate(getLayoutInflater());
        // 액티비티 화면에 출력
        setContentView(binding.getRoot());
        checkBoxes = new CheckBox[3];
        checkBoxes[0] = binding.checkBoxLearnLanguageJava;
        checkBoxes[1] = binding.checkBoxLearnLanguagePhython;
        checkBoxes[2] = binding.checkBoxLearnLanguageC;

        binding.buttonSelectLanguage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String check_Sum = "선택된 언어 \n";
                for (int i = 0; i < checkBoxes.length; i++){
                    if(checkBoxes[i].isChecked()){
                        check_Sum += checkBoxes[i].getText().toString()+" ";
                    }
                }
                if(!checkBoxes[0].isChecked() && !checkBoxes[1].isChecked() && !checkBoxes[2].isChecked()){
                    check_Sum += "선택된 언어가 없습니다.";
                }
                binding.selectLanguage.setText(check_Sum);
            }
        });
    }
}