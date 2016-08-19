//
//数据文件
//

//shape
typedef enum {
	KLineShape=0,
	KCurveShape,
	KRectShape,
	KEllipseShape,
	KImageShape,
	KMoreShape
}ShapeType;

//color
typedef enum {
	KRedColor=0,
	KGreenColor,
	KBlueColor,
	KRandomColor
}ColorIndex;

//action
typedef enum {
	KprepareAction,
	KPainAction,
	KNewAction,
	KUndoAction,
	KRedoAction
}Action;

//every byte of color
typedef struct {
	Byte color_R;
	Byte color_G;
	Byte color_B;
	Byte color_A;
}ShadowColor;

//list of color
static ShadowColor shadowColorList[8]={
	{0,255,0,255},
	{112,74,25,255},
	{255,0,0,255},
	{255,87,87,255},
	{255,0,255,255},
	{0,255,255,255},
	{0,0,255,255},
	{255,255,0,255}
};
#define DegressToRadian(x) (M_PI*(x)/180.0)