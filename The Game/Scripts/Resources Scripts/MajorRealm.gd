class_name MajorRealm
extends  Resource

@export var displayName : String = "Unnamed"
@export var myMinorRealms: Array[MinorRealm]

var minorRealmAmount : int

func setData():
	minorRealmAmount = myMinorRealms.size()
	testPrint()



func sendMinorRealms():
	return myMinorRealms

func testPrint():
	print(minorRealmAmount)


	#"MajorRealm1": {
		#"Name" : "Realm 1",
		#"MajorOrder" : 1,
		#"MinorRealm1" : {
			#"Name" : "Minor 1",
			#"MinorOrder" : 1,
			#"XpToLevel" : 1000
		#},
