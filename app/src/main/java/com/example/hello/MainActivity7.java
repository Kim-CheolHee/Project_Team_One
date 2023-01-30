package com.example.hello;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity7 extends AppCompatActivity {

    TextView learn_Language;
    TextView select_Language;
    CheckBox java;
    CheckBox Phython;
    CheckBox C;
    Button button_select_language;
    CheckBox[] checkBoxes;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity7_main);

        learn_Language = findViewById(R.id.learn_Language);
        select_Language = findViewById(R.id.select_Language);
        checkBoxes = new CheckBox[3];
        java = findViewById(R.id.checkBox_learnLanguage_java);
        checkBoxes[0] = java;
        Phython = findViewById(R.id.checkBox_learnLanguage_Phython);
        checkBoxes[1] = Phython;
        C = findViewById(R.id.checkBox_learnLanguage_C);
        checkBoxes[2] = C;
        button_select_language = findViewById(R.id.button_select_language);


        button_select_language.setOnClickListener(new View.OnClickListener() {
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
                select_Language.setText(check_Sum);
            }
        });
    }
}