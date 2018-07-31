package net.codejava.email;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/EmailSendingServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class EmailSendingServlet extends HttpServlet {
	private String host;
	private String port;
	private String user;
	private String pass;
	private String recipient;
	private String fromAddress;

	public void init() {
		// reads SMTP server setting from web.xml file
		ServletContext context = getServletContext();
		host = context.getInitParameter("host");
		port = context.getInitParameter("port");
		user = context.getInitParameter("user");
		pass = context.getInitParameter("pass");
		recipient = context.getInitParameter("recipient");
		fromAddress = context.getInitParameter("fromAddress");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<File> uploadedFiles = saveUploadedFiles(request);

		String name = request.getParameter("name");
		String subject = "IDIES Order - " + name;

		String priority = request.getParameter("priority");
		String type = request.getParameter("type");
		String account = request.getParameter("account");
		String tag = request.getParameter("tag");
		String vendor = request.getParameter("vendor");
		String reason = request.getParameter("reason");
		String approval = request.getParameter("approval");
		String approverEmail = request.getParameter("approverEmail");
		String quoteReq = request.getParameter("quoteReq");
		String quoteType = request.getParameter("quoteType");
		String soleJustification = request.getParameter("soleJustification");
		String soleJustificationExplanation = request.getParameter("soleJustificationExplanation");

		String content = "Name: " + name + "<br/>" + "Priority: " + priority + "<br/>" + "Type of Order: " + type
				+ "<br/>" + "Account to Charge: " + account + "<br/>" + "Tag: " + tag + "<br/>" + "Vendor: " + vendor
				+ "<br/>" + "Quote Required: " + quoteReq + "<br/>" + "Reason for Purchase: " + reason + "<br/>"
				+ "Purchase Approval: " + approval
				+ (approverEmail != null && approverEmail.length() > 0 ? "<br/>" + "Approver Email: " + approverEmail
						: "")
				+ (quoteType != null && quoteType.length() > 0 ? "<br/>" + "Quote Type: " + quoteType
						: "")
				+ (soleJustification != null && soleJustification.length() > 0 ? "<br/>" + "Sole Justification: " + soleJustification
						: "")
				+ (soleJustificationExplanation != null && soleJustificationExplanation.length() > 0 ? "<br/>" + "Sole Justificaiton Explanation: " + soleJustificationExplanation
						: "");
		
		

		String resultMessage = "";

		try {
			EmailUtility.sendEmailWithAttachment(host, port, user, pass, recipient, subject, content, uploadedFiles,
					approverEmail, fromAddress);
			resultMessage = "Your Order Request has been sent successfully";
		} catch (Exception ex) {
			ex.printStackTrace();
			resultMessage = "There were an error: " + ex.getMessage();
		} finally {
			request.setAttribute("Message", resultMessage);
			getServletContext().getRequestDispatcher("/Result.jsp").forward(request, response);
			deleteUploadFiles(uploadedFiles);
		}
	}

	/*
	 * Saves files uploaded from the client and return a list of these files which
	 * will be attached to the e-mail message.
	 */
	private List<File> saveUploadedFiles(HttpServletRequest request)
			throws IllegalStateException, IOException, ServletException {
		List<File> listFiles = new ArrayList<File>();
		byte[] buffer = new byte[4096];
		int bytesRead = -1;
		Collection<Part> multiparts = request.getParts();
		if (multiparts.size() > 0) {
			for (Part part : request.getParts()) {
				// creates a file to be saved
				String fileName = extractFileName(part);
				if (fileName == null || fileName.equals("")) {
					// not attachment part, continue
					continue;
				}

				File saveFile = new File(fileName);
				System.out.println("saveFile: " + saveFile.getAbsolutePath());
				FileOutputStream outputStream = new FileOutputStream(saveFile);

				// saves uploaded file
				InputStream inputStream = part.getInputStream();
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
				outputStream.close();
				inputStream.close();

				listFiles.add(saveFile);
			}
		}
		return listFiles;
	}

	/**
	 * Retrieves file name of a upload part from its HTTP header
	 */
	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return null;
	}

	/**
	 * Deletes all uploaded files, should be called after the e-mail was sent.
	 */
	private void deleteUploadFiles(List<File> listFiles) {
		if (listFiles != null && listFiles.size() > 0) {
			for (File aFile : listFiles) {
				aFile.delete();
			}
		}
	}
}