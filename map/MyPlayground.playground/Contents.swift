import UIKit

var str = "Hello, playground"

var data = "2021-02-23 00:00:00"
data.split(separator: " ", maxSplits: 1)
print (data.split(separator: " ", maxSplits: 1)[0])

var array:[String] = []
array.append(String(data.split(separator: " ", maxSplits: 1)[0]))
print(array[0])
