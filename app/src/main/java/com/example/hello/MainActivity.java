package com.example.hello;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    // 프로그램의 시작점 역할 onCreate
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);
        setContentView(R.layout.test2);
//        LinearLayout linearLayout = new LinearLayout(this);
//        Button btn = new Button(this);
//        btn.setText("버튼");
//        linearLayout.addView(btn);
//        setContentView(linearLayout);
    }

    public void btnClick1(View v){
        // Toast 클래스
        // : 사용자를 위한 간단한 메시지가 포함
        Toast.makeText(getApplicationContext(), "버튼 눌림", Toast.LENGTH_SHORT).show();
        TextView tv = findViewById(R.id.btn2);
        tv.setText("안녕");
    }

    public void btnClick2(View v){
        Intent myint1 = new Intent(Intent.ACTION_VIEW, Uri.parse("https://m.naver.com"));
        startActivity(myint1);
    }

    public void btnClick3(View v){
        Intent myint1 = new Intent(Intent.ACTION_VIEW, Uri.parse("tel:010-1234-5678"));
        startActivity(myint1);
    }

}