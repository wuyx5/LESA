#include <cstring>
#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	int j;
	mxArray *cell;

	if (nrhs != 0)
		mexErrMsgTxt("usage: O = DodecaElements");

	if (nlhs != 0 && nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	plhs[0] = mxCreateCellMatrix(1,60);

	for (j = 0; j < 60; ++j) {
		cell = mxCreateDoubleMatrix(3,3,mxREAL);
		memcpy(mxGetPr(cell),DodecaElements[j][0]+0,9*sizeof(double));
		mxSetCell(plhs[0],j,cell);
	}
}
