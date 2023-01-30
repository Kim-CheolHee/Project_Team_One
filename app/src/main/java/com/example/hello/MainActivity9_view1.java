package com.example.hello;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

import com.example.hello.databinding.ActivityMainActivity9View1Binding;


public class MainActivity9_view1 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ActivityMainActivity9View1Binding binding1 = ActivityMainActivity9View1Binding.inflate(getLayoutInflater());
        setContentView(binding1.getRoot());

        Intent intent = getIntent();
        String message = intent.getStringExtra("msgV2");
        binding1.textViewAc9v1.setText(message);

        binding1.buttonViewFirst.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // 인텐트 객체 생성
                // - 첫번째 매개변수 : 메세지를 보내는 액티비티
                // - 두번째 매개변수 : 호출하고 싶은 액티비티 -> 화면 전환하고 싶은 액티비티 클래스
                Intent intent = new Intent(getApplicationContext(), MainActivity9_view2.class);
                // * editText의 getText( ) 함수가 리턴하는 타입은?
                // : String 클래스 타입이 아님 // editable 인터페이스 타입을 리턴함
                String str = binding1.inputTextView1.getText().toString();
                intent.putExtra("msgV1", str);
                startActivity(intent);
            }
        });

    }
}