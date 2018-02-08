
<?php
header('Content-type: text/json; charset=UTF-8' );

/**
 * $_FILES 文件上传变量，是一个二维数组，第一维保存上传的文件的数组，第二维保存文件的属性，包括类型、大小等
 * 要实现上传文件，必须修改权限为加入可写 chmod -R 777 目标目录
 */
error_reporting(ALL);
// 文件类型限制
// "file"名字必须和iOS客户端上传的name一致
if (($_FILES["file"]["type"] == "image/gif")
    || ($_FILES["file"]["type"] == "image/jpeg")
    || ($_FILES["file"]["type"] == "image/png")
    || ($_FILES["file"]["type"] == "image/pjpeg")
    || ($_FILES["file"]["type"] == "video/mp4"))

// && ($_FILES["file"]["size"] < 20000)) // 小于20k
{
    if ($_FILES["file"]["error"] > 0) {
        echo $_FILES["file"]["error"]; // 错误代码
    } else {
        $fillname = $_FILES['file']['name']; // 得到文件全名
        $dotArray = explode('.', $fillname); // 以.分割字符串，得到数组
        $type = end($dotArray); // 得到最后一个元素：文件后缀


        $dir = iconv("UTF-8", "GBK", "./pics");
        if (!file_exists($dir)){
            mkdir ($dir,0777,true);
        } else {

        }

        $name = $_POST['time']; // 得到文件全名
        $path = "./pics/".$name.'.'.$type; // 产生随机唯一的名字
        move_uploaded_file( // 从临时目录复制到目标目录
            $_FILES["file"]["tmp_name"], // 存储在服务器的文件的临时副本的名称
            $path);
        $arry  = array( 'messsage' => "1");
        fclose($myfile);
        echo json_encode($arry);
    }
} else {
    echo "文件类型不正确";
}
?>
