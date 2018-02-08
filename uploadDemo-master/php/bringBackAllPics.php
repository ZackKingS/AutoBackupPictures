<?php
$dir = "./pics/";  //要获取的目录
//echo "********** 获取目录下所有文件和文件夹 ***********<hr/>";
//先判断指定的路径是不是一个文件夹

$a = [];

if (is_dir($dir)){
    if ($dh = opendir($dir)){
        while (($file = readdir($dh))!= false){

            if ($file == "." || $file == "..") continue;
//            $filePath = $file;
           $a[]=$file;

        }

        sort ( $a   );

        echo json_encode($a);
        closedir($dh);


    }
}
?>