package com.example.hello;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

import com.example.hello.databinding.ActivityMainActivity9View2Binding;


public class MainActivity9_view2 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ActivityMainActivity9View2Binding binding2 = ActivityMainActivity9View2Binding.inflate(getLayoutInflater());
        setContentView(binding2.getRoot());

        Intent intent = getIntent();
        String message = intent.getStringExtra("msgV1");
        binding2.textViewAc9v2.setText(message);

        binding2.buttonViewFirst.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // 인텐트 객체 생성
                // - 첫번째 매개변수 : 메세지를 보내는 액티비티
                // - 두번째 매개변수 : 호출하고 싶은 액티비티 -> 화면 전환하고 싶은 액티비티 클래스
                Intent intent = new Intent(getApplicationContext(), MainActivity9_view1.class);

                String str = binding2.inputTextView2.getText().toString();
                intent.putExtra("msgV2", str);

                startActivity(intent);
                finish();
            }
        });
    }
}