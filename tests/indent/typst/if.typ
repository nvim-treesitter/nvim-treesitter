#if true {
	"this is one leve"
}

#set page(header: {
	if true {
		"this is internal on level"
	}
})

#if true {
	if false {
		"this is it"
	}
}
