package com.example.hello;

import android.os.Bundle;
import android.widget.RadioGroup;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity6 extends AppCompatActivity {

    TextView select_season;
    RadioGroup radioGroup;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity6_main);

        select_season = findViewById(R.id.select_season);
        radioGroup = findViewById(R.id.radioGroup_seasons);

        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup radioGroup, int i) {
                switch (i){
                    case R.id.radioBtnSpring:
                        select_season.setText("봄");
                        break;
                    case R.id.radioBtnSummer:
                        select_season.setText("여름");
                        break;
                    case R.id.radioBtnFall:
                        select_season.setText("가을");
                        break;
                    case R.id.radioBtnWinter:
                        select_season.setText("겨울");
                        break;
                }
            }
        });
    }
}