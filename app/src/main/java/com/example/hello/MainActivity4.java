package com.example.hello;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity4 extends AppCompatActivity {

    ImageView image;
    int imageIndexL = 0;
    int imageIndexR = 0;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity4_main);

        Button btn_rabbit = findViewById(R.id.btn_rabbit);
        Button btn_fox = findViewById(R.id.btn_fox);
        Button btn_weasel = findViewById(R.id.btn_weasel);
        ImageView btn_left = findViewById(R.id.imageLeft);
        ImageView btn_right = findViewById(R.id.imageRight);
        image = findViewById(R.id.imageView2);

        btn_rabbit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                image.setImageResource(R.drawable.tibetan_rabbit);
            }
        });

        btn_fox.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                image.setImageResource(R.drawable.tibetan_sand_fox);
            }
        });

        btn_weasel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                image.setImageResource(R.drawable.tibetan_weasel);
            }
        });

        btn_left.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(imageIndexL == 0){
                    image.setImageResource(R.drawable.tibetan_weasel);
                    imageIndexL = 1;
                } else if(imageIndexL == 1){
                    image.setImageResource(R.drawable.tibetan_sand_fox);
                    imageIndexL = 2;
                } else if(imageIndexL == 2){
                    image.setImageResource(R.drawable.tibetan_rabbit);
                    imageIndexL = 0;
                }
            }
        });
        btn_right.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(imageIndexR == 0){
                    image.setImageResource(R.drawable.tibetan_sand_fox);
                    imageIndexR = 1;
                } else if(imageIndexR == 1){
                    image.setImageResource(R.drawable.tibetan_weasel);
                    imageIndexR = 2;
                } else if(imageIndexR == 2){
                    image.setImageResource(R.drawable.tibetan_rabbit);
                    imageIndexR = 0;
                }
            }
        });
    }

//    public void onBTNClicked1(View v){
//        ImageView image = findViewById(R.id.imageView2);
//        image.setImageResource(R.drawable.tibetan_rabbit);
//    }
//    public void onBTNClicked2(View v){
//        ImageView image = findViewById(R.id.imageView2);
//        image.setImageResource(R.drawable.tibetan_sand_fox);
//    }
//    public void onBTNClicked3(View v){
//        ImageView image = findViewById(R.id.imageView2);
//        image.setImageResource(R.drawable.tibetan_weasel);
//    }
}
